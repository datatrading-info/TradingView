get_src(str) =>
    x = str == 'Open' ?
      open:
     str == 'High' ?
      high:
     str == 'Low' ?
      low:
     str == 'Close' ?
      close:
     str == 'HL2' ?
      hl2:
     close
    x