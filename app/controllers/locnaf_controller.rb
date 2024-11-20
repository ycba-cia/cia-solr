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

  def submit
    input_name = params["input_name"]
    output_name = params["output_name"]
    l = Locnaf.create(input_name: input_name, output_name: output_name)
    @input_name = l.input_name
    @output_name = l.output_name
  end

  def delete1
    @pinput_name = params["input_name"]
    n = Locnaf.where(input_name: @pinput_name)
    n.each do |n1|
      @input_name = n1["input_name"]
      @output_name = n1["output_name"]
    end
  end

  def delete2
    @input_name = params["input_name"]
    @output_name = params["output_name"]
    Locnaf.where(input_name: @input_name).destroy_all
  end
end