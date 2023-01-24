

class BookmarkImportJob < ActiveJob::Base
  queue_as :urgent

  def perform(id)
    ib = ImportBookmark.find id.to_i
    return if ib == nil

    ib.queued = true
    ib.save!

    fd = File.open(ib.location, "r")
    bookmarks = Markio::parse(fd)
    ib.count = 0
    ib.total = bookmarks.length
    ib.save!

    bookmarks.each do |b|
      puts b.title           # String
      puts b.href            # String with bookmark URL
      # b.folders         # Array of strings - folders (tags)
      # b.add_date        # DateTime
      # b.last_visit      # DateTime
      # b.last_modified   # DateTime

      bk = Document.find_by_location b.href
      if bk == nil

        bk = Document.new
        bk.doc_type = "Bookmark"
        bk.content = ""
        bk.location = b.href
        bk.title = b.title
        bk.description = ""
        bk.image_url = ""
        bk.tags = ""
        bk.collection = 0
        bk.last_visited = DateTime.new
        bk.save

      end

      ib.count = ib.count + 1
      ib.save!
    end
    fd.close

    ib.processed = true
    ib.save!

  end
end

