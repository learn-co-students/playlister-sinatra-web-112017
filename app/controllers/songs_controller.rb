class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :"songs/new"
  end

  patch '/songs/:slug' do


    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])


    if !params[:artist][:name].empty?
      @artist = Artist.find_or_create_by(params[:artist])
      @song.artist = @artist
      @song.save
    end

    params[:genres].each do |genre|
      if genre[:name]
        @genre = Genre.find_or_create_by(genre)
        SongGenre.find_or_create_by({song: @song, genre: @genre})
      end
    end

    params[:genre_ids].each do |g|
      SongGenre.find_or_create_by({song: @song, genre: Genre.find(g)})
    end

    flash[:message] = "Successfully updated song."
    redirect "songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    @artists = Artist.all
    erb :"songs/edit"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

  post '/songs' do
    @song = Song.find_or_create_by(params[:song])
    if !params[:artist][:name].empty?
      @artist = Artist.find_or_create_by(params[:artist])
      @song.artist = @artist
      @song.save
    end

    params[:genres].each do |genre|
      if genre[:name]
        @genre = Genre.find_or_create_by(genre)
        SongGenre.find_or_create_by({song: @song, genre: @genre})
      end
    end

    if params[:genre_ids]
      params[:genre_ids].each do |g|
        SongGenre.find_or_create_by({song: @song, genre: Genre.find(g)})
      end
    end

    flash[:message] = "Successfully created song."
    redirect "songs/#{@song.slug}"
  end

end
