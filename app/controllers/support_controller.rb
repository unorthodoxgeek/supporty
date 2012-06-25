class SupportController < ApplicationController

	include SupportsHelper

	def index
		@title = t("supporty.titles.index")
	end

	def new
		@title = t("supporty.titles.new_ticket")
		@ticket = Support.new
		support_user
	end

	def create
		@ticket = Support.new(params[:support])
		if @ticket.save
			flash[:notice] = t("supporty.flashes.ticket_created")
			redirect_to Support.config("success_redirect_path")
		else
			render "new"
		end
	end

	def show
		@title = t("supporty.titles.show_ticket")
		@ticket = Support.find(params[:id])
	end

	def check_helper
		support_user
		render :nothing => true
	end

end
