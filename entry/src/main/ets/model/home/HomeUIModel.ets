export enum ServiceMode {
  SERVING = 'SERVING',
  IDLE = 'IDLE'
}

@ObservedV2
export class HomeUIModel {
  @Trace serverMode: ServiceMode
  @Trace serviceHoursToday: number
  @Trace receptionsToday: number
  @Trace ratingToday: number
  public static Empty = new HomeUIModel(ServiceMode.IDLE, 0, 0, 0)

  constructor(
    serverMode: ServiceMode,
    serviceHoursToday: number,
    receptionsToday: number,
    ratingToday: number
  ) {
    this.serverMode = serverMode;
    this.serviceHoursToday = serviceHoursToday;
    this.receptionsToday = receptionsToday;
    this.ratingToday = ratingToday;
  }
}