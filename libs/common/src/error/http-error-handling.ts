import { HttpException, InternalServerErrorException } from '@nestjs/common';

export const httpErrorHandling = (e) => {
  if (e.response?.data) {
    throw new HttpException(
      {
        statusCode: e.response.data.statusCode,
        message: e.response.data.message,
        error: e.response.data.error,
      },
      e.response.data.statusCode,
    );
  } else if (e.response?.statusCode) {
    throw new HttpException(
      {
        statusCode: e.response.statusCode,
        message: e.response.message,
        error: e.response.error,
      },
      e.response.statusCode,
    );
  } else {
    throw new InternalServerErrorException();
  }
};
