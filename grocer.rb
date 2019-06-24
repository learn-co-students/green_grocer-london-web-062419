require 'pry'
def consolidate_cart(cart)
  cart_hash = {}  # establish a new array 
  cart.each do |item| # iterate over the cart hash
    item.each do |name, value| # iterate over each item in the cart
      if cart_hash[name]        # need to brush up on the count section
        cart_hash[name][:count] += 1 
      else 
        cart_hash[name] = value 
        cart_hash[name][:count] = 1 
      end 
    end 
  end
  cart_hash # return new hash

end

def apply_coupons(cart, coupons)
  # code here	  
  coupons.each do |coupon| # iterate over each coupon
    if cart.keys.include? coupon[:item]  # if the cart keys(item) include the coupon item. 
      if cart[coupon[:item]][:count] >= coupon[:num]  #if cart coupon item and count is bigger than coupon num
        new_name = "#{coupon[:item]} W/COUPON" # set a new variable = to coupon item
        if cart[new_name]
          cart[new_name][:count] += coupon[:num] # set item count + or = to coupon number
        else
          cart[new_name] = { # builds a new hash
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num] # doesn't break if there is no new coupon. 
      end
    end
  end
  cart #return the cart 
end	


def apply_clearance(cart) 
  cart.keys.each do |item| # iterate over each cart item. 
    if cart[item][:clearance] # if it's true
      cart[item][:price] = (cart[item][:price]*0.80).round(2) # apply 20% discount
    end
  end
  cart
end


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)  # setting a new variable to equal the consolidate cart method. 
  couponed_cart = apply_coupons(consolidated_cart, coupons) # setting a new variable to equal the apply coupons method.
  final_cart = apply_clearance(couponed_cart) # setting a new variable to the apply_cleareance method.
  total = 0  # new variable set to 0 
    final_cart.each do |name, properties| # iterate over the apply clearance cart
        total += properties[:price] * properties[:count]  # total += item price times item count
    end
      total = total * 0.9 if total > 100 # apply 10% discount.
    total
end





