class LocnafController < ApplicationController

  def index
  end

  def listing
    @t = Locnaf.all.order(input_name: :asc)
    @t = Kaminari.paginate_array(@t).page(params[:page]).per(50)
  end

  def lookup
    @name = params["name"]
    @namelist = Array.new
    n = Locnaf.where("input_name LIKE (?)", "%#{@name}%")
    n.each do |n1|
      @namelist.append([n1["input_name"],n1["output_name"]])
    end
  end

  def confirm
    @input_name = params["input_name"]
    @output_name = params["output_name"]


  end
end