class StoreController < ApplicationController

  def index
    #raise current_user.inspect
    @categories = Category.all
    @items = Item.available_items
  end
  
end
