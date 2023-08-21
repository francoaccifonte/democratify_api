import React from 'react'
import withStyles from 'react-jss'
import { Text } from '../../../common'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { adminPalette } from '../../../ColorPalette'

type ImportInProgressProps = {
  classes: any
}

const ImportInProgress = (props: ImportInProgressProps) => {
  return (
    <div className={props.classes.empyState} >
    <Text type="bodyRegular" color="white">
      <FontAwesomeIcon icon={['fas', 'hourglass-half']} /><Text type='bodyRegular'>Esta lista podria estar incpompleta ya que estamos importando tus playlists</ Text>
      <br />
      <Text type="bodyRegular">Vuelve mas tarde para ver la lista completa</Text>
    </Text>
  </div>
  )
}

const styles = (theme: typeof adminPalette) => {
  return {
    empyState: {
      color: theme.White
    }
  }
}
export default withStyles(styles)(ImportInProgress)
