defmodule RumblWeb.VideoView do
  use RumblWeb, :view

  def category_select_options(categories) do
    # views are just modules with pure functions
    for category <- categories do
      {category.name, category.id}
    end
  end
end
