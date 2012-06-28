class SupportController < ApplicationController

  before_filter :require_user, :only => [:index, :show]
  before_filter :get_ticket, :only => [:show, :update]

  include SupportsHelper

  def index
    @title = t("supporty.titles.index")
    populate_tickets
  end

  def new
    @title = t("supporty.titles.new_ticket")
    @ticket = Support.new
    support_user
  end

  def show
    @title = t("supporty.titles.show_ticket")
  end

  def create
    @ticket = Support.new(params[:support])
    @ticket.user_id = support_user.try(:id)
    if @ticket.save
      flash[:notice] = t("supporty.flashes.ticket_created")
      redirect_to Support.config("success_redirect_path")
    else
      render "new"
    end
  end

  def update
    response = params[:ticket]

    if support_agent?
      response[:agent] = true
    end

    @ticket.add_response!(response, support_user)
    redirect_to action: :show, id: @ticket.id
  end

  def gateway
    Support::MailGateway.gateway.handle!(params)
    render nothing: true
  end

  private

  def populate_tickets
    if support_agent?
      populate_for_agent
    else
      populate_for_client
    end
  end

  def populate_for_agent
    @tickets = Support.open.where(["agent_id IS NULL OR agent_id = ?", support_user.id])
  end

  def populate_for_client
    @tickets = Support.open.for_user(support_user.id)
  end

  def require_user
    redirect_to :action => "new" and return if support_user.blank?
  end

  def get_ticket
    @ticket = Support.find(params[:id])
    if !support_agent? && @ticket.user_id != support_user.id
      redirect_to action: :index
    end
  end

end
