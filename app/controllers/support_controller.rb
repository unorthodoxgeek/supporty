class SupportController < ApplicationController

	def new
		@title = t("new_support_ticket_title")
		@ticket = Support.new
	end

	def create
		@ticket = Support.new(params[:support])
		if @ticket.save
			flash[:notice] = t(:support_ticket_created_notice)
			redirect_to root_path
		else
			render "new"
		end
	end

	def show
		@title = t("show_support_ticket")
		@ticket = Support.find(params[:id])
	end

end
