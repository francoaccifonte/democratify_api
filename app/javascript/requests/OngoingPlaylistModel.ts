// import { serializedOngoingPlaylist } from '../components/types/'
import BaseModel from './base_model'
// import { Song } from '../../types/song'
// import { serializedSpotifySong } from '../components/types'

class OngoingPlaylistModel extends BaseModel {
  modelName (): string {
    return ('api/ongoing_playlists')
  }

  async start (playlistId: number, songId?: number) {
    const response = await this.post({
      spotify_playlist_id: playlistId,
      playling_song_id: songId
    })
    console.log(response)
    return response
  }

  // reorder (id: number, songs: Song[], poolSize: number) {
  //   const body = {
  //     pool_size: poolSize,
  //     spotify_playlist_songs: songs.map((song, index) => {
  //       return (
  //         {
  //           id: song.id,
  //           index: index
  //         }
  //       )
  //     })
  //   }

  //   return this.put(id, body)
  // }
}

export default OngoingPlaylistModel
