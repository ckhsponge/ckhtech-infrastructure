class SinsController < BaseController
  get '/' do
    @sins = Sin.where(type: Sin).scan_index_forward(false).record_limit(10).to_a
    @count = Sin.count
    haml :'sins/index'
  end

  post '/commit' do
    Sin.create_with_description  params[:description]
    redirect '/'
  end

  # get '/reset' do
  #   raise "not allowed" unless development?
  #   table = RecordBase.table_name
  #   Dynamoid.adapter.delete_table(table)
  #   Dynamoid.adapter.tables.clear
  #   RecordBase.create_table(sync: true) # create and wait for completion
  #   redirect '/'
  # end
end
