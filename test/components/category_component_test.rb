# frozen_string_literal: true

#class CategoryComponentTest < ViewComponent::TestCase
#  
#  test "should render an empty category" do
#    assert_equal(
#      %(<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-gray-300\" href=\"/\">Cualquiera</a>),
#      render_inline(CategoryComponent.new).to_html
#    )
#  end
#
#  test "should re#nder a category" do#
#    category = Ca#tegory.last#
#    assert_equal(#
#      %(<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-white\" #href=\"/?category_id=#{category.id}\">#{category.name}</a>),
#      render_inline(CategoryComponent.new(category: category)).to_html
#    )
#  end
#end