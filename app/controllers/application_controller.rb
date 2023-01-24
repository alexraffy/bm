class ApplicationController < ActionController::Base
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers


  def render_404
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PATCH, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PATCH, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end


  def ping
    render :json => { :pong => DateTime.now.to_s }
  end


  def verify_token
    puts "token is nil" if params[:token].nil?
    return render :json => { :accepted => false } if params[:token].nil?
    return render :json => { :accepted => false } unless helpers.session_is_valid?(params[:token])
  end


end
