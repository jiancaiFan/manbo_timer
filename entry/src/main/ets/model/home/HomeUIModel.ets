export enum ServiceMode {
  SERVING = 'SERVING',
  IDLE = 'IDLE'
}

export enum ProjectType {
  MASSAGE = 'MASSAGE',
  GUA_SHA = 'GUA_SHA',
  CUPPING = 'CUPPING',
  FOOT_SPA = 'FOOT_SPA'
}

@ObservedV2
export class HomeUIModel {
  @Trace serverMode: ServiceMode;
  @Trace serviceHoursToday: number;
  @Trace receptionsToday: number;
  @Trace incomeToday: number;
  @Trace projectList: ProjectItem[];
  public static Empty = new HomeUIModel(ServiceMode.IDLE, 0, 0, 0, [])

  constructor(
    serverMode: ServiceMode,
    serviceHoursToday: number,
    receptionsToday: number,
    incomeToday: number,
    projectList: ProjectItem[]
  ) {
    this.serverMode = serverMode;
    this.serviceHoursToday = serviceHoursToday;
    this.receptionsToday = receptionsToday;
    this.incomeToday = incomeToday;
    this.projectList = projectList;
  }
}

export class ProjectItem {
  projectName: string;
  projectType: ProjectType;
  projectTotalDuration: number;
  projectIntervalDuration: number;
  projectAmount: number;

  constructor(
    projectName: string,
    projectType: ProjectType,
    projectTotalDuration: number,
    projectIntervalDuration: number,
    projectAmount: number
  ) {
    this.projectName = projectName;
    this.projectType = projectType;
    this.projectTotalDuration = projectTotalDuration;
    this.projectIntervalDuration = projectIntervalDuration;
    this.projectAmount = projectAmount;
  }
}