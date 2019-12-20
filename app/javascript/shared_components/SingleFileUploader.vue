<template>
  <div
    class="dropbox"
    :style="{backgroundImage: imgUrl, minHeight: minHeight, marginTop: dropMargin}"
  >
    <input
      type="file"
      :name="name"
      @change="filesChange($event.target.name, $event.target.files); fileName = $event.target.files[0].name"
      accept="image/*, .pdf"
      class="input-file"
      :disabled="isSaving"
      :style="{minHeight: minHeight}"
    />
    <p v-if="isInitial" :style="{marginTop: pMargin}">{{inputText}}</p>
    <p v-if="isSaving" :style="{marginTop: pMargin}">Téléchargement {{ fileName }} ...</p>
    <v-btn absolute dark fab small top right color="error" v-if="isSaving" @click="reset()">
      <v-icon>delete</v-icon>
    </v-btn>
  </div>
</template>

<script>
const STATUS_INITIAL = 0,
  STATUS_SAVING = 1;

export default {
  name: "SingleFileUploader",
  props: {
    name: String,
    backgroundImg: String,
    inputText: String,
    minHeight: {
      type: String,
      default: "200px"
    },
    dropMargin: {
      type: String,
      default: "50px"
    },
    pMargin: {
      type: String,
      default: "-65px"
    }
  },
  data() {
    return {
      uploadedFiles: [],
      uploadError: null,
      currentStatus: null,
      uploadFieldName: "photos"
    };
  },
  computed: {
    isInitial() {
      return this.currentStatus === STATUS_INITIAL;
    },
    isSaving() {
      return this.currentStatus === STATUS_SAVING;
    },
    imgUrl() {
      return `url(${this.backgroundImg})`;
    }
  },
  methods: {
    reset() {
      // reset form to initial state
      this.currentStatus = STATUS_INITIAL;
      this.uploadedFiles = [];
      this.$emit("inputChange", this.name, { data: null, filename: null });
    },
    filesChange(fieldName, fileList) {
      // handle file changes
      // const formData = new FormData();
      this.uploadedFiles = fileList;
      const reader = new FileReader();

      // formData.append(fieldName, fileList[0], fileList[0].name);
      reader.readAsDataURL(this.uploadedFiles[0]);

      this.currentStatus = STATUS_SAVING;
      reader.onloadend = () => {
        this.$emit("inputChange", this.name, {
          data: reader.result,
          filename: this.uploadedFiles[0].name
        });
      };
      // save it
    }
  },
  mounted() {
    this.reset();
  }
};
</script>


<style lang="scss">
.theme--dark.v-btn:not(.v-btn--icon):not(.v-btn--flat) {
  right: -10px;
}
.dropbox {
  border: 1px dashed #777;
  margin: 10px;
  padding: 10px 10px;
  position: relative;
  cursor: pointer;
  background-position: center;
  background-size: cover;
  transition: 0.5s all;
  width: 100%;
}

.input-file {
  opacity: 0; /* invisible but it's there! */
  width: 100%;
  position: absolute;
  cursor: pointer;
}

.dropbox:hover {
  transform: scale(1.05);
}

.dropbox p {
  font-weight: bold;
  font-size: 1.2em;
  text-align: center;
  padding: 10px 10px;
}
</style>
