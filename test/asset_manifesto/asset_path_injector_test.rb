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
    
    def test_it_handles_multi_line_strings
      input = 'src:url("/images/themes/stowe_realty_34/fonts/f0052336-792e-4fcf-8750-fe6d7d5dccba.eot?#iefix") format("eot"),url("/images/themes/stowe_realty_34/fonts/1b696b29-a6bd-4411-a50f-37fd8a209b36.woff") format("woff"),url("/images/themes/stowe_realty_34/fonts/a3931c31-5998-4dbd-b7d5-d310e4ed3d60.ttf") format("truetype"),url("/images/themes/stowe_realty_34/fonts/6779412d-2ea7-4f1a-acfd-f6a527baaee7.svg#6779412d-2ea7-4f1a-acfd-f6a527baaee7") format("svg");'
      output = 'src:url(<%= asset_path "themes/stowe_realty_34/fonts/f0052336-792e-4fcf-8750-fe6d7d5dccba.eot" %>) format("eot"),url(<%= asset_path "themes/stowe_realty_34/fonts/1b696b29-a6bd-4411-a50f-37fd8a209b36.woff" %>) format("woff"),url(<%= asset_path "themes/stowe_realty_34/fonts/a3931c31-5998-4dbd-b7d5-d310e4ed3d60.ttf" %>) format("truetype"),url(<%= asset_path "themes/stowe_realty_34/fonts/6779412d-2ea7-4f1a-acfd-f6a527baaee7.svg" %>) format("svg");'
      
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
    
    def test_it_handles_multi_line_strings
      input = 'src:url("/images/themes/stowe_realty_34/fonts/f0052336-792e-4fcf-8750-fe6d7d5dccba.eot?#iefix") format("eot"),url("/images/themes/stowe_realty_34/fonts/1b696b29-a6bd-4411-a50f-37fd8a209b36.woff") format("woff"),url("/images/themes/stowe_realty_34/fonts/a3931c31-5998-4dbd-b7d5-d310e4ed3d60.ttf") format("truetype"),url("/images/themes/stowe_realty_34/fonts/6779412d-2ea7-4f1a-acfd-f6a527baaee7.svg#6779412d-2ea7-4f1a-acfd-f6a527baaee7") format("svg");'
      output = 'src:url(<%= asset_path "themes/stowe_realty_34/fonts/f0052336-792e-4fcf-8750-fe6d7d5dccba.eot" %>) format("eot"),url(<%= asset_path "themes/stowe_realty_34/fonts/1b696b29-a6bd-4411-a50f-37fd8a209b36.woff" %>) format("woff"),url(<%= asset_path "themes/stowe_realty_34/fonts/a3931c31-5998-4dbd-b7d5-d310e4ed3d60.ttf" %>) format("truetype"),url(<%= asset_path "themes/stowe_realty_34/fonts/6779412d-2ea7-4f1a-acfd-f6a527baaee7.svg" %>) format("svg");'
      
      assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
    end
  end
  
  def test_it_should_ignore_non_query_string_question_marks
    input = 'height: expression( this.scrollHeight > 249 ? "250px" : "auto" ); /* sets max-height for IE */'
    output = 'height: expression( this.scrollHeight > 249 ? "250px" : "auto" ); /* sets max-height for IE */'
    
    assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
  end
  
  def test_it_should_ignore_query_strings_on_external_referrenced_links
    input = '@import url("http://fast.fonts.net/t/1.css?apiType=css&projectid=4305220f-250c-4931-bf43-2e1f6d2a5ff7")'
    output = '@import url(<%= asset_path "http://fast.fonts.net/t/1.css?apiType=css&projectid=4305220f-250c-4931-bf43-2e1f6d2a5ff7" %>)'
    
    assert_equal output, AssetManifesto::AssetPathInjector.to_asset_pipeline(input)
  end
end
