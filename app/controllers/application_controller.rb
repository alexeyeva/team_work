class ApplicationController < ActionController::Base
  MAIN_DOMAIN = "teamwork.in.ua"
  include Permissions
  protect_from_forgery with: :exception
  helper_method :current_organization

  before_action :validate_domain
  before_action :authenticate_user!#, except: [:index]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).concat [:name]
    devise_parameter_sanitizer.for(:account_update).concat [:name]
  end

protected

  def current_domain
    @current_domain = request.domain
  end

  def current_subdomain
    @current_subdomain = Rails.env.development? ? request.domain.split(".").first : request.subdomain
  end

  def current_organization(domain_or_subdomain=nil)
    #TODO: need cache organizations list and first organization
    @current_organization = Organization.find_by_domain(current_domain)
  end

private

  def render_404_domain
    render :file => "#{Rails.root}/public/404_domain", :layout => false, :status => :not_found
  end

  def root?(type = "/")
    request.path == type
  end

  def localhost?
    localhost = %w(127.0.0.0 localhost 0.0.0.0 lvh.me team_work)
    localhost.include?(request.domain)
  end

  def validate_domain
    if current_organization.present?
      true
    else
      render_404_domain
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
