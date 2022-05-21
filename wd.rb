require 'erb'

$posts = [] # array for all the post titles

def createPost(title, content)
  # set up all the variables for the template
  $postTitle = title[11..].gsub(/[-]/, " ")
  $postDate = title[0..9] 
  $postContent = content

  # set up the ERB class to fill the template
  rhtml = ERB.new(File.read("templates/post.erb"))

  post = rhtml.result
  return post
end

def searchAllFiles()
  Dir.foreach("uploads") do | postFile |
    next if postFile == "." or postFile == ".."
    postContent = ""
    File.foreach("uploads/#{postFile}") { |txt| postContent = txt } 
    # make the title for the post and the filename
    title = postFile.split(".")[0]
    post = createPost(title, postContent)
    # save the content of the posts to a html file in de posts directory
    savePostFile = File.new("posts/#{title}.html", "w+")
    savePostFile.puts(post)
    savePostFile.close
    # put the posttitle in the posts array
    $posts.push(title)
  end
end

searchAllFiles()

indexrhtml = ERB.new(File.read("templates/index.erb"))
index = indexrhtml.result
# save the index file 
saveIndexFile = File.new("index.html", "w+")
saveIndexFile.puts(index)
saveIndexFile.close
