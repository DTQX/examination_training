<template>
  <a-form :model="formState" :label-col="labelCol" :wrapper-col="wrapperCol">
    <a-form-item label="地区">
      <a-select v-model:value="formState.region">
        <a-select-option value="江西">江西</a-select-option>
      </a-select>
    </a-form-item>
    <a-form-item label="年份">
      <a-select v-model:value="formState.year">
        <a-select-option v-for="item in years" :key="item" :value="item">{{
          item
        }}</a-select-option>
      </a-select>
    </a-form-item>
    <a-form-item label="科目">
      <a-select v-model:value="formState.subject">
        <a-select-option v-for="item in subjects" :key="item" :value="item">{{
          item
        }}</a-select-option>
      </a-select>
    </a-form-item>
    <a-form-item label="总分（分）">
      <a-input-number v-model:value="formState.score" />
    </a-form-item>
    <a-form-item label="时长（分）">
      <a-input-number v-model:value="formState.timeM" />
    </a-form-item>
    <a-form-item label="名称">
      <a-input v-model:value="formState.name" />
    </a-form-item>
    <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
      <a-button type="primary" @click="onSubmit">开始录题</a-button>
      <a-button style="margin-left: 10px">取消</a-button>
    </a-form-item>
  </a-form>

  <div>
    <div>题目1</div>
    <input ref="q_1" placeholder="粘贴题目" />
    <input :ref="'a_1'" placeholder="粘贴答案" />
  </div>
</template>

<script>
import { tos } from "../utils";
import { message } from "ant-design-vue";
export default {
  name: "AddTest",
  props: {
    msg: String,
  },
  data() {
    return {
      years: [2021, 2020, 2019, 2018, 2017],
      subjects: ["数学", "理综", "物理", "化学", "生物"],
      formState: {
        region: "江西",
        year: 2021,
        subject: "数学",
        score: "",
        timeM: "",
        name: "",
      },
    };
  },
  mounted() {
    console.log("q_1", this.$refs.q_1, this.$refs.a_1);
    const handler = (e) => {
      console.log("e", e);
      const file = e.clipboardData.files[0];
      if (!file) {
        return;
      }
      tos
        .upload("test", file)
        .then(() => {
          message.info("图片上传成功");
        })
        .catch(() => {
          message.error("图片上传失败");
        });
    };
    this.$refs.q_1.addEventListener("paste", handler);
  },
  methods: {
    onSubmit() {
      console.log("submit!", JSON.stringify(this.formState));
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
