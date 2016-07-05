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
    
    def test_it_handles_query_strings
      input = "url(/images/themes/windwalker/fonts/EBGaramond-webfont.eot?#iefix) format('embedded-opentype')"
      output = "url(<%= asset_path 'themes/windwalker/fonts/EBGaramond-webfont.eot' %>) format('embedded-opentype')"
      
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
    
    def test_it_handles_query_strings
      input = "url(themes/windwalker/fonts/EBGaramond-webfont.eot?#iefix) format('embedded-opentype')"
      output = "url(<%= asset_path 'themes/windwalker/fonts/EBGaramond-webfont.eot' %>) format('embedded-opentype')"
      
      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end
  end
end
