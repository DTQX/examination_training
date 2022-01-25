<template>
  <a-form :model="formState" :label-col="labelCol" :wrapper-col="wrapperCol">
    <a-form-item label="名称">
        <a-input v-model:value="formState.name" />
    </a-form-item>
    <a-form-item label="地区">
      <a-select v-model:value="formState.region">
        <a-select-option value="江西">江西</a-select-option>
        <a-select-option value="jack">Jack</a-select-option>
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
      <a-input-number v-model:value="formState.duration" />
    </a-form-item>
    
    
  </a-form>

  <a-row v-for="(item, index) in questionList" :key="item.id">
    <a-col :span="2">{{index+1}}</a-col>
    <a-col :span="16">
      <a-row>
        <a-col :span="24">
          <a-select v-model:value="item.subject" placeholder="科目" style="width: 120px">
            <a-select-option v-for="subject in subjects" :key="subject" :value="subject">{{
              subject
            }}</a-select-option>
          </a-select>
        </a-col>
        <!-- <a-col :span="12">
          <a-input v-model:value="item.recommendedTime" placeholder="推荐答题时间(分)" />
        </a-col> -->
      </a-row>
      <a-row>
        <a-col :span="12">
          <img v-if="item.qUrl"  :src="item.qUrl" style="width:100%"/>
          <input v-else  @paste="(e)=> handlePaste(e,index, 'qUrl')" placeholder="粘贴题目" style="width:100%" />
        </a-col>
        <a-col :span="12">
          <img v-if="item.aUrl"  :src="item.aUrl" style="width:100%"/>
          <input v-else  @paste="(e)=> handlePaste(e,index, 'aUrl')" placeholder="粘贴答案" style="width:100%"/>
        </a-col>
      </a-row>
    </a-col>
    <a-col :span="6">
      <a-button @click="reset(index)">重置</a-button>
      <a-button @click="add(index)">新增</a-button>
      <a-button @click="del(index)" danger :disabled="index === 0">删除</a-button>
    </a-col>
  </a-row>

  <a-row style="margin-top:50px;padding-left:200px">
    <a-button type="primary" @click="savePaper">保存试卷</a-button>
    <a-button style="margin-left: 10px">取消</a-button>
  </a-row>
  
</template>

<script>
import { tos,AddTestPaper } from "../utils";
import { message } from "ant-design-vue";
import { v4 as uuid } from 'uuid';
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
        name: "",
      },
      questionList:[this.getEmptyQuestion()],
    };
  },
  mounted() {
    // console.log("q_1", this.$refs.q_1, this.$refs.a_1);
    
    // this.$refs.q_1.addEventListener("paste", handler);
  },
  methods: {
    handlePaste(e,index, type){
      console.log("e", e,index);
      const file = e.clipboardData.files[0];
      if (!file) {
        return;
      }
      tos
        .upload(uuid()+'.jpg', file)
        .then((res) => {
          message.info("图片上传成功");
          this.questionList[index][type] = res.url;
        })
        .catch((err) => {
          message.error("图片上传失败："+JSON.stringify(err));
        });
    },
    async savePaper() {
      console.log("submit!", JSON.stringify(this.formState));
    
      const res = await AddTestPaper({...this.formState,questions: this.questionList })
      if(res.code === 0){
        message.info("保存成功")
      }else{
        message.error("保存失败")
      }
    },
    reset(index){
      this.questionList[index].qUrl = "";
      this.questionList[index].aUrl = "";
      this.questionList[index].subject = null;

    },
    add(index){
      this.questionList.splice(index+1, 0, this.getEmptyQuestion())
    },
    del(index){
      this.questionList.splice(index, 1);
    },
    getEmptyQuestion(){
      return {
        id: uuid(),
        qUrl:'',
        aUrl:'',
        subject: this.formState?.subject !== '理综' ?  this.formState?.subject : null,
        // recommendedTime:'',
      }
    }
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
