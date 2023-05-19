const popularPersonResponseBody = {
  'results': [
    {
      'id': 1,
      'name': 'Actor 1',
      'profile_path': '/path/to/profile1.jpg',
      'known_for': [
        {
          'id': 1,
          'title': 'Movie 1',
          'media_type': 'movie',
          'poster_path': '/path/to/poster1.jpg',
          'release_date': '2021-01-01',
        },
        {
          'id': 2,
          'title': 'Movie 2',
          'media_type': 'movie',
          'poster_path': '/path/to/poster2.jpg',
          'release_date': '2021-01-01',
        },
      ]
    },
    {
      'id': 2,
      'name': 'Actor 2',
      'profile_path': '/path/to/profile2.jpg',
      'known_for': [
        {
          'id': 3,
          'title': 'TV Show 3',
          'media_type': 'tv',
          'poster_path': '/path/to/poster3.jpg',
          'first_air_date': '2021-01-01',
        },
        {
          'id': 4,
          'title': 'TV Show 4',
          'media_type': 'tv',
          'poster_path': '/path/to/poster4.jpg',
          'first_air_date': '2021-01-01',
        },
      ]
    },
  ],
};
