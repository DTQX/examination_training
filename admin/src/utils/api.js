import axios from "axios";

const instance = axios.create({
  baseURL: "https://qchtxq.api.cloudendpoint.cn/",
  timeout: 1000,
  // headers: {'X-Custom-Header':'foobar'}
});

export const AddTestPaper = async (paper) => {
  return (await instance.post("/add_test_paper", paper)).data;
};
