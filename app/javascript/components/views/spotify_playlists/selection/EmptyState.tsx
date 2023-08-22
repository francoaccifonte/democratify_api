import React from 'react'
import withStyles from 'react-jss'
import { serializedSpotifyPlaylist } from '../../../types'
import { Text } from '../../../common'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { adminPalette } from '../../../ColorPalette'

type EmptyStateProps = {
  playlists: serializedSpotifyPlaylist[],
  classes: any
}

const startImport = async (event: React.MouseEvent<HTMLAnchorElement>) => {
  return null
}

const EmptyState = (props: EmptyStateProps) => {
  return (
    <div className={props.classes.empyState}>
      <Text type="bodyImportant" color="white" className={props.classes.captionOne}>
        <FontAwesomeIcon className={props.classes.icon} icon={['fas', 'microphone-slash']} /> No se encontraron playlists.
        <br />
        <Text type='bodyRegular'>
          <a className={props.classes.link} href='spotify_playlists/import' onClick={startImport}>
            Haz click para importarlas desde tu cuenta de Spotify
          </a>
        </Text>
      </Text>
  </div>
  )
}

const styles = (theme: typeof adminPalette) => {
  return {
    empyState: {
      color: theme.White,
      paddingTop: '1rem'
    },
    icon: {
      marginRight: '1rem'
    },
    link: {
      textDecoration: 'inherit',
      color: 'inherit',
      cursor: 'pointer'
    }
  }
}
export default withStyles(styles)(EmptyState)
