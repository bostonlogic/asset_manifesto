require 'test_helper'

class AssetManifesto::AssetPathInjectorTest < Minitest::Test

  class StartsWithImagesTest < AssetManifesto::AssetPathInjectorTest
    def test_it_handles_single_quotes
      input  = "url('/images/fonts/cardo/cardo-webfont.eot')"
      output = "url(<%= asset_path 'fonts/cardo/cardo-webfont.eot' %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end

    def test_it_handles_double_quotes
      input  = "url(\"/images/fonts/cardo/cardo-webfont.eot\")"
      output = "url(<%= asset_path \"fonts/cardo/cardo-webfont.eot\" %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end

    def test_it_handles_no_quotes
      input  = "url(/images/fonts/cardo/cardo-webfont.eot)"
      output = "url(<%= asset_path 'fonts/cardo/cardo-webfont.eot' %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end
  end

  class DoesNotStartWithImageTest < AssetManifesto::AssetPathInjectorTest
    def test_it_handles_single_quotes
      input  = "url('/fonts/cardo/cardo-webfont.eot')"
      output = "url(<%= asset_path 'fonts/cardo/cardo-webfont.eot' %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end

    def test_it_handles_double_quotes
      input  = "url(\"fonts/cardo/cardo-webfont.eot\")"
      output = "url(<%= asset_path \"fonts/cardo/cardo-webfont.eot\" %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end

    def test_it_handles_no_quotes
      input  = "url(fonts/cardo/cardo-webfont.eot)"
      output = "url(<%= asset_path 'fonts/cardo/cardo-webfont.eot' %>)"

      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end
  end
end
