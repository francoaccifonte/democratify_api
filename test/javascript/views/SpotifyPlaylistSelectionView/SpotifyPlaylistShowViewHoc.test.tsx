import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { SpotifyPlaylistShowViewHoc } from "../../../../app/javascript/components/views/spotify_playlists/selection";
import { buildList, serialized_account_fixture, serialized_spotify_playlist_fixture, serialized_spotify_song_fixture } from "../../factories";
import { toJson } from '../../../../app/javascript/components/types';

const fixture = serialized_spotify_playlist_fixture()
fixture.spotify_songs = buildList(serialized_spotify_song_fixture, 3)

describe("List", () => {
  it("renders a playlist", async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(serialized_account_fixture())} />);

    for (let i = 0; i < fixture.spotify_songs.length; i++) {
      expect(subject.getByText(fixture.spotify_songs[i].title)).toBeInTheDocument
    }
  })

  it("renders the controls", async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(serialized_account_fixture())} />);

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument();
    expect(img).toHaveAttribute('src', fixture.cover_art_url)
  })
})
