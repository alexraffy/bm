require "digest"

class DeviceController < ApplicationController
  skip_before_action :verify_authenticity_token

  def register
    # request
    # device_name:string, master_password:md5_string
    # response
    # accepted: boolean
    # device_id?: string

    if params[:device_name].nil? || params[:master_password].nil?
      return render :json => { :accepted => false }
    end

    master_password = Rails.application.credentials.master_password
    md5_master_password = Digest::MD5.hexdigest(master_password)
    param_master_password = params[:master_password]

    return render :json => { :accepted => false } unless md5_master_password == param_master_password


    new_device = Device.new
    new_device.device_guid = SecureRandom.uuid
    new_device.name = params[:device_name]
    new_device.enabled = true
    new_device.need_confirmation = false
    new_device.info = ""
    new_device.save!

    return render :json => { :accepted => true, :device_id => new_device.device_guid }
  end

  def authenticate
    # request
    # device_id: string
    # password: string
    # response
    # accepted: boolean;
    # limit?: string;
    # token?: string;

    if params[:device_id].nil? || params[:password].nil?
      return render :json => { :accepted => false }
    end

    device = Device.find_by_device_guid(params[:device_id])
    return render :json => { :accepted => false } if device.nil?


    session = Session.new
    session.token = SecureRandom.uuid
    session.limit = DateTime.now + 5.minutes
    session.device = device.id
    session.save!

    return render :json => { :accepted => true, :limit => session.limit, :token => session.token }
  end

end
