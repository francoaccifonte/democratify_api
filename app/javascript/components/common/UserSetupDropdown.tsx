import React from 'react'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import withStyles from 'react-jss'
import Dropdown from 'react-bootstrap/Dropdown'
import Cookies from 'js-cookie'

// import { openQrOnNewWindow } from './qr'

type UserSetupDropdownProps = {
  classes: any
}

const UserSetupDropdown = (props: UserSetupDropdownProps) => {
  const { classes } = props

  const handleLogout = () => {
    // TODO
    // localStorage.removeItem('account_token')
    // window.location.href = '/'
  }
  const accountId = Cookies.get('account_id')

  type FarafaProps = { children: any, onClick: any }
  const Farafa = React.forwardRef((props: FarafaProps, ref: any) => (
    <a
      ref={ref}
      onClick={(e) => {
        e.preventDefault()
        props.onClick(e)
      }}
    >
      <div className={classes.userMenuContainer}>
        <div className={classes.userMenu}><FontAwesomeIcon icon={['fas', 'user-circle']} /></div>
        <FontAwesomeIcon icon={['fas', 'sort-down']} />
      </div>
      {props.children}
    </a>
  ))
  Farafa.displayName = 'Farafa'

  return (
    <>
      <Dropdown>
        <Dropdown.Toggle variant="none" id="dropdown-basic" as={Farafa}>
          {/* <div className={props.classes.userMenu}><FontAwesomeIcon icon={['fas', 'user-circle']} /></div> */}
        </Dropdown.Toggle>

        <Dropdown.Menu>
          <Dropdown.Item onClick={() => { window.location.href = '/account_settings' }}>Configuracion de Streaming</Dropdown.Item>
          <Dropdown.Item onClick={() => { window.location.href = '/spotify_playlists' }}>Mis Playlists</Dropdown.Item>
          <Dropdown.Item onClick={() => { window.location.href = '/ongoing_playlists' }}>Reproduccion Activa</Dropdown.Item>
          {/* <Dropdown.Item onClick={() => openQrOnNewWindow(accountId)}>QR Votacion</Dropdown.Item> */}
          <Dropdown.Divider />
          <Dropdown.Item onClick={handleLogout}>Salir</Dropdown.Item>
        </Dropdown.Menu>
      </Dropdown>
    </>
  )
}

const styles = (theme: any) => {
  return {
    userMenuContainer: {
      display: 'flex',
      flexDirection: 'row',
      alignItems: 'center'
    },
    userMenu: {
      color: theme.White,
      fontSize: '3rem',
      composes: 'pe-4'
    }
  }
}

export default withStyles(styles)(UserSetupDropdown)
