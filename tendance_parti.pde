float getTendance(String parti) {
  switch(parti) {
    case "SRC":
    case "SER":
      return -0.5;
    case "GDR":
      return -1.;
    case "UMP":
    case "LES-REP":
      return 0.6;
    case "RRDP":
      return 0.;
    case "ECOLO":
      return -0.6;
    case "UDI":
      return 0.2;
    default:
      return 0.;
  } 
}