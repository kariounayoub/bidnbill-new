<template>
  <div id='footer'>
    <p>
      <span>© Bill Selector 2019</span>
      <span>Données personnelles</span>
      <span>Mentions Légals</span>
    </p>
  </div>
</template>

<script>
  export default {
    name: 'Footer',
  }
</script>

<style scoped lang='scss'>
  #footer {
    margin-top: 40px;
    height: 100px;
     background: linear-gradient(98.45deg, var(--v-success-base) -22.29%, #FFFFFF 248.81%);
     display: flex;
     justify-content: center;
     align-items: center;
     font-size: 14px;
     font-weight: 700;
     color: white;
     p {
      margin: 0;
     }
     span {
      margin: 0 10px;
     }
  }
</style>
