class CartsController < ApplicationController

  def show
    @cart = Cart.find_by_id(params[:id])
  end

  def checkout
    cart = Cart.find_by_id(params[:id])
    cart.update_inventory
    current_user.current_cart = nil
    current_user.save
    flash[:notice] = 'Thanks for the business!'
    redirect_to cart_path(params[:id])
  end

end
