import { ProjectItem, ProjectType } from "../../model/home/HomeUIModel";
import { common } from "@kit.AbilityKit";
import { util } from "@kit.ArkTS";

export class HomeMapper {
  public static toHomeProjectsUIModel(context: common.UIAbilityContext): Promise<ProjectItem[]> {
    return new Promise((resolve, reject) => {
      context.resourceManager.getRawFileContent("defaultProjects.json")
        .then((getJson) => {
          const textDecoderOptions: util.TextDecoderOptions = { ignoreBOM: true };
          const textDecoder = util.TextDecoder.create("utf-8", textDecoderOptions);
          const result = textDecoder.decodeToString(getJson);

          const projects: ProjectItem[] = (JSON.parse(result) as Array<Record<string, string | number>>)
            .map((item) => {
              let projectType: ProjectType = ProjectType.MASSAGE;
              if (item["projectType"] === ProjectType.GUA_SHA) {
                projectType = ProjectType.GUA_SHA;
              } else if (item["projectType"] === ProjectType.CUPPING) {
                projectType = ProjectType.CUPPING;
              } else if (item["projectType"] === ProjectType.FOOT_SPA) {
                projectType = ProjectType.FOOT_SPA;
              }

              return new ProjectItem(
                String(item["projectName"] ?? ""),
                projectType,
                Number(item["projectTotalDuration"] ?? 0),
                Number(item["projectIntervalDuration"] ?? 0),
                Number(item["projectAmount"] ?? 0)
              );
            });
          resolve(projects);
        })
        .catch(() => {
          console.log("homeProjectList", "fetch data error");
          reject(new Error("获取失败"));
        });
    });
  }
}