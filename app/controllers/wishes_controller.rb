class WishesController < ApplicationController
  before_filter :authenticate_user!

  def index
    return root_path unless current_user.credential.present?
  end

  def create
    wish = current_user.wish.new(:wish => params[:wish][:wish], date: Date.strptime(params[:date], "%m/%d/%Y"))
    respond_to do |format|
      if wish.save
        return redirect_to root_path, notice: "Wish saved sucessfully!"
      else
        @error = wish.errors.full_messages.first
        format.js { render "wishes/show_error" }
      end
    end
  end

  def update
    wish = Wish.find(params[:id])
    wish.wish = params[:wish][:wish]
    respond_to do |format|
      if wish.save
          return redirect_to root_path, notice: "Success!"
        else
          @error = wish.errors.full_messages.first
          format.js { render "wishes/show_error"  }
      end
    end
  end

  def fetch_wish
    if !current_user.wish
      @wish = current_user.build_wish
      @wish.date = Date.today
    else
      @wish = current_user.wish
      @wish.date = Date.today
    end
    respond_to do |format|
      format.js
    end
  end
end
