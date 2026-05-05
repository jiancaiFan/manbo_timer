import { ProjectItem, ProjectType } from "../../model/home/HomeUIModel";

export class HomeMapper {
  public static toHomeProjectsUIModel(): Promise<ProjectItem[]> {
    return new Promise((resolve, reject) => {
      try {
        resolve([
          new ProjectItem('全身经络', ProjectType.MASSAGE, 60, 15, 298),
          new ProjectItem('局部肩颈', ProjectType.THERAPY, 30, 5, 128),
          new ProjectItem('足底反射', ProjectType.MASSAGE, 45, 12, 198),
          new ProjectItem('专业刮痧', ProjectType.GUA_SHA, 30, 10, 158),
          new ProjectItem('深层拔罐', ProjectType.CUPPING, 30, 10, 138),
          new ProjectItem('尊享推油', ProjectType.MASSAGE, 90, 20, 398)
        ]);
      } catch (error) {
        console.error("homeProjectList", "fetch data error", error);
        reject(new Error("获取失败"));
      }
    })
  }

  public static async toDialogTabList(): Promise<string[]> {
    return ["按摩", "刮痧", "拔罐", "理疗"];
  }
}