require 'test_helper'

class AssetManifestoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AssetManifesto::VERSION
  end

  def test_it_responds_to_generate_all_manifests
    assert_respond_to AssetManifesto, :generate_all_manifests
  end

  def test_it_responds_to_asset_pipeline_setup
    assert_respond_to AssetManifesto, :asset_pipeline_setup
  end
end
