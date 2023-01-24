

class BookmarkController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:collection] == nil
      @bookmarks = Bookmark.all
    else
      @bookmarks = Bookmark.all.find_all do |b|
        b.collection == params[:collection].to_i
      end
    end
    render :json => @bookmarks
  end




  def import
    uploaded_file = params[:file]
    filename = uploaded_file.original_filename
    extension = filename.split(".").last
    tmp_file = "#{Rails.root}/tmp/#{SecureRandom.uuid}.#{extension}"
    puts tmp_file

    File.open(tmp_file, 'wb') do |f|
      data = uploaded_file.read
      f.write  data
    end

    ib = ImportBookmark.new
    ib.location = tmp_file
    ib.processed = false
    ib.queued = false
    ib.save!

    BookmarkImportJob.perform_later ib.id.to_s


    render :json => { :request_id => ib.id }
  end


  def import_status
    ib = nil
    begin
      request_id = params[:request_id]
      ib = ImportBookmark.find request_id
    rescue
      render_404
      return
    end

    render :json => { :request_id => ib.id, :processed => ib.processed, :total => ib.total, :count => ib.count }

  end


end
