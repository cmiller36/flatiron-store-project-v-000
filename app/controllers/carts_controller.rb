class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :checkout]

  def show
    @current_cart = current_user.current_cart
  end

  def checkout
    @cart.checkout
    redirect_to cart_path(@cart)
  end

  private



  def set_cart
    @cart = Cart.find(params[:id])
  end

end
