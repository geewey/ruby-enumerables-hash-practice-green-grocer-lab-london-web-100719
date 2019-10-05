 require "pry"

def consolidate_cart(cart)
  consolidate = Hash.new # create hash, default value = nil
  
  cart.each do |array| # {AVO..AVO..KALE}
    array.each do |item, attribute| # avocado => :price =>, etc.
    
      if !consolidate[item] # check if avo hash exists...
        consolidate[item] = Hash.new # if not, create hash for item
        consolidate[item] = {:count => 1} # avocado => :count..
      else # if avo hash exists
        consolidate[item][:count] += 1 # increment
      end
      consolidate[item].merge!(attribute) # merge price, clearance
    end            
  end
  
  return consolidate
end


  # need to check cases, ex: if coupons (:item => "item") matches any key ("item") in the cart
  # if no, then return item
  # if yes, then do the following...
  
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    if cart[coupon_item]
      if coupon[:num] <= cart[coupon_item][:count] &&
      !cart.has_key?("#{coupon_item} W/COUPON")
      
        cart["#{coupon_item} W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]),
          :clearance => cart[coupon_item][:clearance],
          :count => coupon[:num]
        }
        cart[coupon_item][:count] -= coupon[:num]
        
      elsif coupon[:num] <= cart[coupon_item][:count] &&
      cart.has_key?("#{coupon_item} W/COUPON")
        
        cart["#{coupon_item} W/COUPON"][:count] += coupon[:num]
        cart[coupon_item][:count] -= coupon[:num]
        
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, attribute|
    if attribute[:clearance] == true
      original_price = cart[item][:price]
      discount = 0.2
      discounted_price = original_price * (1.00 - discount)
      cart[item][:price] = discounted_price.round(2)
      binding.pry
    end
    
  binding.pry
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
