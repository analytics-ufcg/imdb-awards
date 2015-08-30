__author__ = 'rafaelle'
# -*- coding: utf-8 -*-

import imdb
print 'movieId,movieTitle,movieDirector,movieRating,movieMetascore,listMovieCast'
ia = imdb.IMDb()
with open('oscar_2000-2014.txt') as f:
    next(f)
    for line in f:
        movie = ia.search_movie(line.split(',')[0])
        movieId = (movie[0]).getID()
        infoMovie = ia.get_movie(movieId)

        # print infoMovie.sumary()

        directorMovie = infoMovie['director'][0]

        ratingMovie = infoMovie['rating']

        castMovie = infoMovie['cast']

        #companiesMovie =  infoMovie['production companies']
        #for company in companiesMovie:
        #    print str(infoMovie) + '  ' + str(company)
        ia.update(infoMovie, 'critic reviews')
        #print infoMovie.get('metascore')

        strCast = '['
        listCast = []
        for cast in castMovie:
            strCast += str(cast) + ', '

        strCast = strCast[:len(strCast)-2] + " ]"


        print str(movieId) + ', ' + str(infoMovie)+ ', '+ str(directorMovie) + ', '+str(ratingMovie) + ', '+ str(infoMovie.get('metascore'))  + ', ' + strCast


