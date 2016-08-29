class StoreController < ApplicationController

   def index
    @user = current_user
    @categories = Category.all
    @items = Item.all
  end
  
end
