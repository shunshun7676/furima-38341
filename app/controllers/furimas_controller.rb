class FurimasController < ApplicationController
 def index
  @furimas = Frima.all
end
end

