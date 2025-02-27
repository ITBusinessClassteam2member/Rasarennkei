# �x�[�X�C���[�W
FROM python:3.10

# ��ƃf�B���N�g����ݒ�
WORKDIR /app

# Flask �A�v���̃\�[�X�R�[�h���R�s�[
COPY ./app /app

# �p�b�P�[�W���C���X�g�[��
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# �|�[�g�����J
EXPOSE 5000

# �A�v�����N��
CMD ["python", "app.py"]
