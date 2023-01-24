class DocumentController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_token

  def index
    selected_collection = params[:collection]
    selected_type = params[:type]
    search = params[:search] == nil ? "" : params[:search]

    @documents = Document.all.find_all do |b|
      (
        (selected_collection == 0 || b.collection == selected_collection.to_i) &&
        (selected_type == "All" || b.doc_type == selected_type) &&
        (search == "" || (b.title.match?( /#{search}/i ) || b.description.match?( /#{search}/i )))
      )
    end

    render :json => @documents
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

  def patch
    document_id = params[:id]
    doc = Document.find(document_id)
    if doc != nil
      if params[:collection] != nil
        doc.collection = params[:collection]
      end

      doc.save!
    end
    render :json => { :request_id => params[:request_id], :id => document_id }
  end

  def new
    if params[:document][:doc_type] == nil || params[:document][:title] == nil || params[:document][:description] == nil ||
      params[:document][:collection] == nil || params[:document][:location] == nil || params[:document][:image_url] == nil ||
      params[:document][:tags] == nil || params[:document][:content] == nil
      return render :json => { :accepted => false, :error => "Invalid parameters" }
    end

    doc = Document.new
    unless params[:document][:id].nil? || params[:document][:id] == 0
      doc = Document.find_by(params[:document][:id])
      return render :json => { :accepted => false, :error => "Document not found."} if doc.nil?
    end
    doc.doc_type = params[:document][:doc_type]
    doc.title = params[:document][:title]
    doc.description = params[:document][:description]
    doc.location = params[:document][:location]
    doc.image_url = params[:document][:image_url]
    doc.tags = params[:document][:tags]
    doc.collection = params[:document][:collection]
    doc.content = params[:document][:content]
    doc.save!

    render :json => { :accepted => true, :id => doc.id }

  end

  def exists
    return render :json => { :accepted => false } if params[:location].nil?
    doc = Document.find_by_location(params[:location])
    return render :json => { :accepted => false } if doc.nil?
    render :json => { :accepted => true, :document => doc }
  end

end
