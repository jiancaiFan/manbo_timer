export enum ServiceMode {
  SERVING = 'SERVING',
  IDLE = 'IDLE'
}

export enum ProjectType {
  MASSAGE = 'MASSAGE',
  GUA_SHA = 'GUA_SHA',
  CUPPING = 'CUPPING',
  THERAPY = 'THERAPY'
}

@ObservedV2
export class HomeUIModel {
  @Trace serverMode: ServiceMode;
  @Trace serviceHoursToday: number;
  @Trace receptionsToday: number;
  @Trace incomeToday: number;
  @Trace projectList: ProjectItem[]|undefined;
  @Trace dialogTabList: string[];
  @Trace currentDialogTab: number;

  public static Empty = new HomeUIModel(ServiceMode.IDLE, 0, 0, 0, undefined, [], 0)

  constructor(
    serverMode: ServiceMode,
    serviceHoursToday: number,
    receptionsToday: number,
    incomeToday: number,
    projectList: ProjectItem[]|undefined,
    dialogTabList: string[],
    currentDialogTab: number
  ) {
    this.serverMode = serverMode;
    this.serviceHoursToday = serviceHoursToday;
    this.receptionsToday = receptionsToday;
    this.incomeToday = incomeToday;
    this.projectList = projectList;
    this.dialogTabList = dialogTabList;
    this.currentDialogTab = currentDialogTab;
  }
}

@ObservedV2
export class ProjectItem {
  @Trace projectName: string;
  @Trace projectType: ProjectType;
  @Trace projectTotalDuration: number;
  @Trace projectIntervalDuration: number;
  @Trace projectAmount: number;

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