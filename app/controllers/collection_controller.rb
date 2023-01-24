


class CollectionController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_token

  def index
    total = 0
    hash_collection = {}
    hash_collection[0] = {
      :id => 0,
      :title => "Unsorted",
      :count => 0,
      :parent_collection => nil,
      :icon => "",
      :color => "bg-white-500"
    }
    collections = Collection.all
    collections.each do |c|
      hash_collection[c.id] = {
        :id => c.id,
        :title => c.title,
        :count => 0,
        :parent_collection => c.parent_collection,
        :icon => c.icon
      }
    end
    documents = Document.all
    documents.each do |b|
      if b.collection.nil?
        puts "Document #{b.title} has a collection set to nil"
        next
      end
      total = total + 1
      hash_collection[b.collection][:count] += 1
      parent = hash_collection[b.collection][:parent_collection]
      while parent != nil
        hash_collection[parent][:count] += 1
        parent = hash_collection[parent][:parent_collection]
      end
    end

    render :json => { :accepted => true, :collections => hash_collection.values }

  end

  def new
    render :json => { :accepted => false } if params[:collection].nil? || params[:collection][:title].nil?
    collection = Collection.new
    collection.title = params[:collection][:title]
    collection.parent_collection = params[:collection][:parent_collection]
    collection.color = params[:collection][:color]
    collection.save!
    render :json => { :accepted => true, :id => collection.id}
  end



end
