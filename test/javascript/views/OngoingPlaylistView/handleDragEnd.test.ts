import '@testing-library/jest-dom'

import { serializedSpotifySong } from '../../../../app/javascript/components/types'
import { SerializedSpotifySongFactory, buildList } from '../../factories'
import { handleDragEnd } from '../../../../app/javascript/components/views/spotify_playlists/OngoingPlaylistView/SongList'

describe('handleDragEnd', () => {
  it('triggers a put request when called', () => {
    const initialSongs: serializedSpotifySong[] = buildList(SerializedSpotifySongFactory, 3)
    const setRemainingSongs = jest.fn()
    const result = {
      source: {
        index: 2
      },
      destination: {
        index: 0
      }
    }

    handleDragEnd(result, initialSongs, setRemainingSongs)
    expect(setRemainingSongs).toHaveBeenCalledWith([
      initialSongs[2], initialSongs[0], initialSongs[1]
    ])
  })
})
