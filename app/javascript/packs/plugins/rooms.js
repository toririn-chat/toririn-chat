const rooms = {
  methods: {
    roomStatusBadgeVariant(status) {
      switch (status) {
        case 'active':
          return 'success';
        case 'inactive':
          return 'danger';
        default:
          return '';
      }
    },
    roomStatusBadgeString(status) {
      switch (status) {
        case 'active':
          return '有効';
        case 'inactive':
          return '無効';
        default:
          return '';
      }
    },
    roomStatusIsActive(status) {
      return status === 'active';
    }
  }
};

export default rooms;
