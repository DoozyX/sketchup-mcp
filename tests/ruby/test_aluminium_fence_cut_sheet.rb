# frozen_string_literal: true

require 'minitest/autorun'

class AluminiumFenceCutSheetTest < Minitest::Test
  SHEET_PATH = File.expand_path('../../docs/aluminium-fence-cut-sheet.html', __dir__)

  def test_standalone_fabrication_sheet_exists
    assert File.file?(SHEET_PATH), 'expected the standalone fabrication HTML sheet to exist'
  end

  def test_sheet_contains_the_model_derived_fabrication_schedule
    html = File.read(SHEET_PATH)

    {
      'fence slat' => '2010 × 140 × 20',
      'fence post' => '1120 × 33 × 20',
      'vehicle gate leaf' => '3788 × 1320 × 78',
      'pedestrian gate leaf' => '771 × 1320 × 102',
      'gate post' => '1500 × 341 × 206',
      'combined gate assembly' => '5100 × 1500 × 379'
    }.each do |label, dimensions|
      assert_includes html, dimensions, "missing #{label} dimensions"
    end

    assert_includes html, '>63<', 'expected 63 horizontal fence slats'
    assert_includes html, '>18<', 'expected 18 fence posts'
    assert_includes html, '>3<', 'expected three gate posts'
    assert_includes html, 'Verify all site openings before cutting'
    assert_includes html, '@page'
    refute_match(/(?:src|href)=["']https?:/i, html, 'sheet must remain standalone')

    part_links = html.scan(/data-part="([a-z0-9-]+)"/).flatten
                     .group_by(&:itself)
                     .transform_values(&:length)
    refute_empty part_links
    part_links.each do |part, occurrences|
      assert_operator occurrences, :>=, 2, "#{part} must link a drawing part to its schedule row"
    end
  end
end
