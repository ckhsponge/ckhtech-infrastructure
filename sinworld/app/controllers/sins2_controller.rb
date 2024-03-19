# class Sins2Controller < BaseController
#   get '/' do
#     @sins = Sin.where(type: Sin).scan_index_forward(false).record_limit(10).to_a
#     @count = Sin.count
#     haml :'sins/index'
#   end
#
#   post '/commit' do
#     if Sin.create(description: description)
#       redirect '/'
#     else
#       redirect '/error'
#     end
#   end
# end
#
