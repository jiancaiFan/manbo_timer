export interface ServiceRecord {
  projectName: string;
  durationMinutes: number;
  amount: number;
  serviceDate: number;
}

@ObservedV2
export class TimerUIModel {
  @Trace serviceRecords: ServiceRecord[];

  public static Empty = new TimerUIModel([])

  constructor(serviceRecords: ServiceRecord[] = []) {
    this.serviceRecords = serviceRecords;
  }
}